
FROM debian:bookworm

RUN apt update -y \
    && apt full-upgrade -y \
    && mkdir /workspace \
    && rm -rf /var/cache/*

RUN apt install -y tree neovim vim wget curl git subversion apt-utils sudo \
    build-essential cmake autoconf automake flex bison m4 \
    unzip bzip2 xz-utils universal-ctags jq \
    git-lfs git-flow git-svn git-all git-doc git-credential-oauth git-crypt \
    bash zsh fish csh tcsh \
    python3 python3-pip python3-venv python3-poetry python3-pytest python3-autopep8 python3-full \
    iverilog verilator yosys gtkwave graphviz \
    bazel-bootstrap perl-doc protobuf-compiler openjdk-17-jdk-headless openjdk-17-jre-headless \
    allure tldr \
    bash-completion zsh-autosuggestions zsh-syntax-highlighting \
    && rm -rf /var/cache/* \
    && pip3 install \
    cocotb \
    cocotb-test \
    flake8 \
    isort \
    pytest \
    yapf    

RUN cd /workspace \
    && git clone --branch v0.0-3430-g060bde0f --depth 1 https://github.com/chipsalliance/verible.git \
    && cd verible \
    && bazel run -c opt :install -- -s /usr/local/bin \
    && cd /workspace \
    && rm -rf verible \
    && rm -rf $HOME/.cache/bazel \
    && rm -rf /var/cache/*

# or RUN apt install libsystemc libsystemc-dev
RUN cd /workspace \
    && wget -c https://github.com/accellera-official/systemc/archive/refs/tags/2.3.4.tar.gz \
    && mkdir /workspace/systemc-2.3.4 \
    && tar -zxvf 2.3.4.tar.gz \
    && cd /workspace/systemc-2.3.4 \
    && mkdir /workspace/systemc-2.3.4/build \
    && aclocal \
    && automake --add-missing \
    && cd build \
    && ../configure --prefix=/usr/local/share/systemc-2.3.4 \
    && make -j$(nproc) \
    && make install \
    && cd /workspace \
    && ln -s /usr/local/share/systemc-2.3.4/lib-linux64/ /usr/local/share/lib \
    && rm -rf /workspace/systemc-2.3.4 \
    && rm -rf /workspace/2.3.4.tar.gz

RUN mkdir /usr/local/share/uvm \
    && wget -c https://accellera.org/images/downloads/standards/uvm/UVM-18002-2020-20tar.gz \
    && tar -zxvf UVM-18002-2020-20tar.gz -C /usr/local/share/uvm \
    && rm -rf UVM-18002-2020-20tar.gz \
    && wget -c https://accellera.org/images/downloads/standards/uvm/UVM-18002-2020-11tar.gz \
    && tar -zxvf UVM-18002-2020-11tar.gz -C /usr/local/share/uvm \
    && rm -rf UVM-18002-2020-11tar.gz \
    && wget -c https://accellera.org/images/downloads/standards/uvm/UVM-18002-2020-10tar.gz \
    && tar -zxvf UVM-18002-2020-10tar.gz -C /usr/local/share/uvm \
    && rm -rf UVM-18002-2020-10tar.gz \
    && wget -c https://accellera.org/images/downloads/standards/uvm/UVM-18002-2017-11tar.gz \
    && tar -zxvf UVM-18002-2017-11tar.gz -C /usr/local/share/uvm \
    && rm -rf UVM-18002-2017-11tar.gz \
    && wget -c https://accellera.org/images/downloads/standards/uvm/Accellera-1800.2-2017-1.0.tar.gz \
    && tar -zxvf Accellera-1800.2-2017-1.0.tar.gz -C /usr/local/share/uvm \
    && rm -rf Accellera-1800.2-2017-1.0.tar.gz \
    && wget -c https://accellera.org/images/downloads/standards/uvm/uvm-1.2.tar.gz \
    && tar -zxvf uvm-1.2.tar.gz -C /usr/local/share/uvm \
    && rm -rf uvm-1.2.tar.gz \
    && wget -c https://accellera.org/images/downloads/standards/uvm/uvm-1.1d.tar.gz \
    && tar -zxvf uvm-1.1d.tar.gz -C /usr/local/share/uvm \
    && rm -rf uvm-1.1d.tar.gz \
    && wget -c https://accellera.org/images/downloads/standards/uvm/uvm-1.1c.tar.gz \
    && tar -zxvf uvm-1.1c.tar.gz -C /usr/local/share/uvm \
    && rm -rf uvm-1.1c.tar.gz \
    && wget -c https://accellera.org/images/downloads/standards/uvm/uvm-1.1b.tar.gz \
    && tar -zxvf uvm-1.1b.tar.gz -C /usr/local/share/uvm \
    && rm -rf uvm-1.1b.tar.gz \
    && wget -c https://accellera.org/images/downloads/standards/uvm/uvm-1.1a.tar.gz \
    && tar -zxvf uvm-1.1a.tar.gz -C /usr/local/share/uvm \
    && rm -rf uvm-1.1a.tar.gz \
    && wget -c https://accellera.org/images/downloads/standards/uvm/uvm-1.0p1.tar.gz \
    && tar -zxvf uvm-1.0p1.tar.gz -C /usr/local/share/uvm \
    && rm -rf uvm-1.0p1.tar.gz

RUN touch /etc/profile.d/systemc.sh \
    && echo 'export SYSTEMC_ROOT=/usr/local/share/systemc-2.3.4' >> /etc/profile.d/systemc.sh \
    && echo 'export SYSTEMC_INCLUDE=$SYSTEMC_ROOT/include' >> /etc/profile.d/systemc.sh \
    && echo 'export SYSTEMC_LIB=$SYSTEMC_ROOT/lib-linux64' >> /etc/profile.d/systemc.sh \
    && echo 'export LD_LIBRARY_PATH=$SYSTEMC_LIB:$LD_LIBRARY_PATH' >> /etc/profile.d/systemc.sh \
    && touch /etc/profile.d/uvm.sh \
    && echo 'export UVM_ROOT=/usr/local/share/uvm' >> /etc/profile.d/uvm.sh \
    && echo 'export UVM_HOME=$UVM_ROOT/1800.2-2020-2.0' >> /etc/profile.d/uvm.sh

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    && sed -i 's/plugins=(git)/plugins=(git git-flow-avh gitignore git-lfs pip)/g' $HOME/.zshrc


RUN groupadd vscode -g 1000 \
    && useradd vscode -u 1000 -g 1000 -s /bin/zsh -m \
    && touch /etc/sudoers.d/vscode \
    && echo 'vscode ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/vscode \
    && chmod 440 /etc/sudoers.d/vscode \
    && chown vscode:vscode /workspace

USER vscode
WORKDIR /workspace

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    && sed -i 's/plugins=(git)/plugins=(git git-flow-avh gitignore git-lfs pip)/g' $HOME/.zshrc \
    && mkdir -p $HOME/.local/share/tldr \
    && tldr --update


