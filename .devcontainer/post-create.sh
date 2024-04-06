#!/bin/bash
set -xe
 
#sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list.d/debian.sources 
#sed -i 's/security.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list.d/debian.sources 
mkdir /workspace 
rm -rf /var/cache/*	
	
DEBIAN_FRONTEND=noninteractive 
apt update -y 
apt full-upgrade -y

apt install -y tree neovim vim wget curl dbus-x11 git subversion apt-utils sudo \
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
	
# Verible
ARCH=$(uname -m)
if [[ $ARCH == "aarch64" ]]; then
    ARCH="arm64"
fi
DIST_ID=$(grep DISTRIB_ID /etc/lsb-release | cut -d'=' -f2)
DIST_RELEASE=$(grep RELEASE /etc/lsb-release | cut -d'=' -f2)
DIST_CODENAME=$(grep CODENAME /etc/lsb-release | cut -d'=' -f2)
VERIBLE_RELEASE=$(curl -s -X GET https://api.github.com/repos/chipsalliance/verible/releases/latest | jq -r '.tag_name')
VERIBLE_TAR=verible-$VERIBLE_RELEASE-linux-static-$ARCH.tar.gz
if [[ ! -f $VERIBLE_TAR ]]; then
    wget https://github.com/chipsalliance/verible/releases/download/$VERIBLE_RELEASE/$VERIBLE_TAR
fi
if [[ ! -f "/usr/local/bin/verible-verilog-format" ]]; then
    tar -C /usr/local --strip-components 1 -xf $VERIBLE_TAR
fi
rm $VERIBLE_TAR

#LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)

# or RUN apt install libsystemc libsystemc-dev
    cd /workspace \
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

    mkdir /usr/local/share/uvm \
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

    touch /etc/profile.d/systemc.sh \
    && echo 'export SYSTEMC_ROOT=/usr/local/share/systemc-2.3.4' >> /etc/profile.d/systemc.sh \
    && echo 'export SYSTEMC_INCLUDE=$SYSTEMC_ROOT/include' >> /etc/profile.d/systemc.sh \
    && echo 'export SYSTEMC_LIB=$SYSTEMC_ROOT/lib-linux64' >> /etc/profile.d/systemc.sh \
    && echo 'export LD_LIBRARY_PATH=$SYSTEMC_LIB:$LD_LIBRARY_PATH' >> /etc/profile.d/systemc.sh \
    && touch /etc/profile.d/uvm.sh \
    && echo 'export UVM_ROOT=/usr/local/share/uvm' >> /etc/profile.d/uvm.sh \
    && echo 'export UVM_HOME=$UVM_ROOT/1800.2-2020-2.0' >> /etc/profile.d/uvm.sh \
    && touch /etc/profile.d/rustup.sh \
    && echo 'export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup' >> /etc/profile.d/rustup.sh \
    && echo 'export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup' >> /etc/profile.d/rustup.sh \
    && touch /etc/profile.d/golang.sh \
    && echo 'export GO111MODULE=on' >> /etc/profile.d/golang.sh \
    && echo 'export GOPATH=/usr/local/share/go/gopath' >> /etc/profile.d/golang.sh \
    && echo 'export GOPROXY=https://goproxy.cn,direct' >> /etc/profile.d/golang.sh

    REMOTE=https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git \
    sh -c "$(curl -fsSL https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh)" \
    && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && sed -i 's/plugins=(git)/plugins=(git git-flow-avh gitignore git-lfs pip)/g' $HOME/.zshrc

