FROM ubuntu:22.04
RUN apt update && \
    apt install curl build-essential git llvm cmake liblldb-dev -y -qq && \
    git clone https://github.com/lldb-tools/lldb-mi && \
    cd lldb-mi && \
    cmake . && \
    cmake build . && \
    make

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    git clone https://github.com/brendandburns/wasmtime

RUN apt install -y -qq pkg-config libssl-dev

RUN cd wasmtime && \
    git fetch origin && \
    git checkout v4.0.0 && \
    git submodule update --init && \
    bash -c 'source $HOME/.cargo/env; cargo build'

FROM ubuntu:22.04

# wasmtime
ENV WASI_VERSION=17
ENV WASI_VERSION_FULL=17.0

RUN apt update && \
    apt install curl xz-utils lldb llvm git nano gdb lighttpd -y -qq && \
    curl https://wasmtime.dev/install.sh -sSf | bash && \
    curl https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-${WASI_VERSION}/wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz -L --output wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz && \
    tar xvf wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz && \
    rm wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz

# llvm setup
# https://github.com/llvm/llvm-project/issues/55575
RUN ln -s /usr/lib/llvm-14/lib/python3.10/dist-packages/lldb/* /usr/lib/python3/dist-packages/lldb/
COPY --from=0 lldb-mi/src/lldb-mi /usr/bin/lldb-mi
RUN ln -s /usr/bin/lldb-mi /usr/bin/lldb-mi-14

# Setup code
RUN git config --global core.editor "code --wait"

# Setup lighthttpd
COPY wagi.sh /usr/bin/wagi.sh
RUN chmod a+x /usr/bin/wagi.sh

# Setup wasi+http
COPY --from=0 wasmtime/target/debug/wasmtime /usr/bin/wasmtime-http
