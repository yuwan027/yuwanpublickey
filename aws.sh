#!/bin/bash

# 安装nyanpass，指定安装名为yuwan，不优化系统参数，不安装常用工具
S=yuwan OPTIMIZE=0 INSTALL_TOOLS=0 bash <(curl -fLSs https://dl.nyafw.com/download/nyanpass-install.sh) rel_nodeclient "-t c80b404e-5b8e-44aa-bb9a-3c488ca1638a -u https://ny.pccwg.us"

# 设置系统参数并启用BBR
rm -rf /etc/sysctl.d/*
echo 'net.ipv4.tcp_congestion_control = bbr
net.core.default_qdisc = fq_pie
fs.file-max = 1000000
fs.inotify.max_user_instances = 8192
fs.pipe-max-size = 1048576
fs.pipe-user-pages-hard = 0
fs.pipe-user-pages-soft = 0
net.core.somaxconn = 3276800
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_keepalive_time = 600
net.ipv4.tcp_keepalive_probes = 3
net.ipv4.tcp_keepalive_intvl = 15
net.ipv4.tcp_retries1 = 5
net.ipv4.tcp_retries2 = 5
net.ipv4.tcp_orphan_retries = 3
net.ipv4.tcp_fin_timeout = 2
net.ipv4.tcp_max_tw_buckets = 4096
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_abort_on_overflow = 0
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_stdurg = 0
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_sack = 1
net.ipv4.tcp_fack = 1
net.ipv4.tcp_dsack = 1
net.ipv4.tcp_frto = 2
net.ipv4.tcp_ecn = 1
net.ipv4.tcp_ecn_fallback = 1
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_reordering = 300
net.ipv4.tcp_retrans_collapse = 0
net.ipv4.tcp_autocorking = 1
net.ipv4.tcp_low_latency = 0
net.ipv4.tcp_slow_start_after_idle = 1
net.ipv4.tcp_no_metrics_save = 0
net.ipv4.tcp_moderate_rcvbuf = 1
net.ipv4.tcp_tso_win_divisor = 3
net.ipv4.tcp_mtu_probing = 1
net.ipv4.tcp_rfc1337 = 1
net.ipv4.ip_forward = 1
net.ipv4.route.gc_timeout = 100
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_ignore_bogus_error_responses = 1
net.core.netdev_max_backlog = 16384
net.core.netdev_budget = 600
net.core.optmem_max = 81920
net.core.wmem_default = 262144
net.core.wmem_max = 67108864
net.core.rmem_default = 262144
net.core.rmem_max = 67108864
net.ipv4.tcp_mem = 786432 2097152 3145728
net.ipv4.tcp_rmem = 4096 524288 67108864
net.ipv4.tcp_wmem = 4096 524288 67108864
net.ipv4.udp_rmem_min = 8192
net.ipv4.udp_wmem_min = 8192' | tee /etc/sysctl.d/yuwan.conf

# 重置sysctl配置并应用新的系统设置
echo '' > /etc/sysctl.conf
sysctl --system

# 更新系统并安装必要软件包
export DEBIAN_FRONTEND=noninteractive
apt update && apt install mtr traceroute vim nano bash sudo wget curl net-tools iperf3 dnsutils htop iftop screen -y

nohup iperf3 -s > /dev/null 2>&1 &
