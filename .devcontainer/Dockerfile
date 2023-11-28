# Copyright 2023 仲夏叶.
# SPDX-License-Identifier: Apache-2.0

FROM mcr.microsoft.com/devcontainers/base:bookworm

WORKDIR /workspace

RUN sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list.d/debian.sources \
    && sed -i 's/security.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list.d/debian.sources \
    && apt-get update

RUN apt-get install -y build-essential autoconf automake tree vim wget curl git git-lfs git-flow subversion

RUN wget -c https://github.com/accellera-official/systemc/archive/refs/tags/2.3.4.tar.gz \
    && mkdir /workspace/systemc-2.3.4 \
    && tar -zxvf 2.3.4.tar.gz \
    && cd /workspace/systemc-2.3.4 \
    && mkdir /workspace/systemc-2.3.4/build \
    && aclocal \
    && automake --add-missing \
    && cd build \
    && ../configure --prefix=/usr/local/systemc-2.3.4 \
    && make -j$(nproc) \
    && make install \
    && cd /workspace \
    && ln -s /usr/local/systemc-2.3.4/lib-linux64/ /usr/local/lib \
    && rm -rf /workspace/systemc-2.3.4 \
    && rm -rf /workspace/2.3.4.tar.gz

RUN mkdir /usr/local/uvm \
    && wget -c https://www.accellera.org/images/downloads/standards/uvm/UVM-18002-2020-20tar.gz \
    && tar -zxvf UVM-18002-2020-20tar.gz -C /usr/local/uvm \
    && rm -rf UVM-18002-2020-20tar.gz \
    && wget -c https://www.accellera.org/images/downloads/standards/uvm/UVM-18002-2020-11tar.gz \
    && tar -zxvf UVM-18002-2020-11tar.gz -C /usr/local/uvm \
    && rm -rf UVM-18002-2020-11tar.gz \
    && wget -c https://www.accellera.org/images/downloads/standards/uvm/UVM-18002-2020-10tar.gz \
    && tar -zxvf UVM-18002-2020-10tar.gz -C /usr/local/uvm \
    && rm -rf UVM-18002-2020-10tar.gz \
    && wget -c https://www.accellera.org/images/downloads/standards/uvm/UVM-18002-2017-11tar.gz \
    && tar -zxvf UVM-18002-2017-11tar.gz -C /usr/local/uvm \
    && rm -rf UVM-18002-2017-11tar.gz \
    && wget -c https://www.accellera.org/images/downloads/standards/uvm/Accellera-1800.2-2017-1.0.tar.gz \
    && tar -zxvf Accellera-1800.2-2017-1.0.tar.gz -C /usr/local/uvm \
    && rm -rf Accellera-1800.2-2017-1.0.tar.gz \
    && wget -c https://www.accellera.org/images/downloads/standards/uvm/uvm-1.2.tar.gz \
    && tar -zxvf uvm-1.2.tar.gz -C /usr/local/uvm \
    && rm -rf uvm-1.2.tar.gz \
    && wget -c https://www.accellera.org/images/downloads/standards/uvm/uvm-1.1d.tar.gz \
    && tar -zxvf uvm-1.1d.tar.gz -C /usr/local/uvm \
    && rm -rf uvm-1.1d.tar.gz \
    && wget -c https://www.accellera.org/images/downloads/standards/uvm/uvm-1.1c.tar.gz \
    && tar -zxvf uvm-1.1c.tar.gz -C /usr/local/uvm \
    && rm -rf uvm-1.1c.tar.gz \
    && wget -c https://www.accellera.org/images/downloads/standards/uvm/uvm-1.1b.tar.gz \
    && tar -zxvf uvm-1.1b.tar.gz -C /usr/local/uvm \
    && rm -rf uvm-1.1b.tar.gz \
    && wget -c https://www.accellera.org/images/downloads/standards/uvm/uvm-1.1a.tar.gz \
    && tar -zxvf uvm-1.1a.tar.gz -C /usr/local/uvm \
    && rm -rf uvm-1.1a.tar.gz \
    && wget -c https://www.accellera.org/images/downloads/standards/uvm/uvm-1.0p1.tar.gz \
    && tar -zxvf uvm-1.0p1.tar.gz -C /usr/local/uvm \
    && rm -rf uvm-1.0p1.tar.gz

RUN apt-get install -y iverilog gtkwave verilator perl-doc

RUN apt-get install -y bazel-bootstrap flex bison m4 \
    && git clone --branch v0.0-3430-g060bde0f --depth 1 https://github.com/chipsalliance/verible.git \
    && cd verible \
    && bazel run -c opt :install -- -s /usr/local/bin \
    && cd /workspace \
    && rm -rf verible

RUN touch /etc/profile.d/systemc.sh \
    && echo "export SYSTEMC_ROOT=/usr/local/systemc-2.3.4" >> /etc/profile.d/systemc.sh \
    && echo "export SYSTEMC_INCLUDE=/usr/local/systemc-2.3.4/include" >> /etc/profile.d/systemc.sh \
    && echo "export SYSTEMC_LIB=/usr/local/systemc-2.3.4/lib-linux64" >> /etc/profile.d/systemc.sh \
    && echo "export LD_LIBRARY_PATH=$SYSTEMC_LIB:$LD_LIBRARY_PATH" >> /etc/profile.d/systemc.sh \
    && touch /etc/profile.d/uvm.sh \
    && echo "export UVM_ROOT=/usr/local/uvm" >> /etc/profile.d/uvm.sh \
    && echo "export UVM_HOME=$UVM_ROOT/1800.2-2020-2.0" >> /etc/profile.d/uvm.sh

RUN apt-get install -y python3-full python3-pip \
    && pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

RUN apt-get install -y zsh tcsh fish zsh-syntax-highlighting zsh-autosuggestions \
    && mkdir -p /home/vscode/.oh-my-zsh/custom/plugins \
    && ln -s /usr/share/zsh-syntax-highlighting /home/vscode/.oh-my-zsh/custom/plugins \
    && ln -s /usr/share/zsh-autosuggestions /home/vscode/.oh-my-zsh/custom/plugins \
    && sed -i 's/plugins=(git)/plugins=(git git-flow-avh gitignore git-lfs pip svn vscode zsh-syntax-highlighting zsh-autosuggestions)/g' /home/vscode/.zshrc \
    && chsh -s /bin/zsh vscode
