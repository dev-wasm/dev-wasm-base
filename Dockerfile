FROM ubuntu:22.04
RUN apt update && \
    apt install curl build-essential git -y -qq && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    git clone https://github.com/deislabs/wagi

RUN ln -s /root/.cargo/bin/cargo /usr/bin/cargo
RUN ln -s /root/.cargo/bin/rustc /usr/bin/rustc
RUN apt install -y -qq pkg-config libssl-dev

RUN cd wagi && make

FROM ubuntu:22.04

# wasmtime
ENV WASI_VERSION=17
ENV WASI_VERSION_FULL=17.0

RUN apt update && \
    apt install curl xz-utils lldb llvm git nano gdb -y -qq && \
    curl https://wasmtime.dev/install.sh -sSf | bash && \
    curl https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-${WASI_VERSION}/wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz -L --output wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz && \
    tar xvf wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz && \
    rm wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz

# https://github.com/llvm/llvm-project/issues/55575
RUN ln -s /usr/lib/llvm-14/lib/python3.10/dist-packages/lldb/* /usr/lib/python3/dist-packages/lldb/

# Setup code
RUN git config --global core.editor "code --wait"

COPY --from=0 wagi/target/release/wagi /usr/bin/wagi
