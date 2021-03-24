#!/bin/bash
ZZZ="package/lean/default-settings/files/zzz-default-settings"
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#

sed -i "/uci commit fstab/a\uci commit network" $ZZZ
sed -i "/uci commit network/i\uci set network.lan.ipaddr='192.168.100.252'" $ZZZ              # IPv4 地址(openwrt后台地址)
sed -i "/uci commit network/i\uci set network.lan.netmask='255.255.255.0'" $ZZZ           # IPv4 子网掩码
sed -i "/uci commit network/i\uci set network.lan.gateway='192.168.100.253'" $ZZZ             # IPv4 网关
sed -i "/uci commit network/i\uci set network.lan.broadcast='192.168.100.255'" $ZZZ         # IPv4 广播
sed -i "/uci commit network/i\uci set network.lan.dns='223.5.5.5 114.114.114.114'" $ZZZ   # DNS(多个DNS要用空格分开)
sed -i "/uci commit network/i\uci set network.lan.delegate='0'" $ZZZ                      # 去掉LAN口使用内置的 IPv6 管理

sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile   # 强制选择argon为默认主题选项
sed -i "/uci commit luci/i\uci set luci.main.mediaurlbase=/luci-static/argon" $ZZZ        # 选择argon为默认主题

sed -i "/uci commit system/i\uci set system.@system[0].hostname='OpenWrt-longcat'" $ZZZ       # 修改主机名称为OpenWrt-123

sed -i "s/OpenWrt /龙猫 build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" $ZZZ        # 增加自己个性名称281677160

sed -i '/CYXluq4wUazHjmCDBCqXF/d' $ZZZ                                                    # 设置密码为空

#sed -i 's/PATCHVER:=5.4/PATCHVER:=4.19/g' target/linux/x86/Makefile                      # 修改内核版本为4.19


# 修改插件名字（修改名字后不知道会不会对插件功能有影响，自己多测试）
sed -i 's/"BaiduPCS Web"/"百度网盘"/g' package/lean/luci-app-baidupcs-web/luasrc/controller/baidupcs-web.lua
sed -i 's/cbi("qbittorrent"),_("qBittorrent")/cbi("qbittorrent"),_("BT下载")/g' package/lean/luci-app-qbittorrent/luasrc/controller/qbittorrent.lua
sed -i 's/"aMule设置"/"电驴下载"/g' package/lean/luci-app-amule/po/zh-cn/amule.po
sed -i 's/"网络存储"/"存储"/g' package/lean/luci-app-amule/po/zh-cn/amule.po
sed -i 's/"网络存储"/"存储"/g' package/lean/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po
sed -i 's/"实时流量监测"/"流量"/g' package/lean/luci-app-wrtbwmon/po/zh-cn/wrtbwmon.po
sed -i 's/"KMS 服务器"/"KMS激活"/g' package/lean/luci-app-vlmcsd/po/zh-cn/vlmcsd.zh-cn.po
sed -i 's/"TTYD 终端"/"命令窗"/g' package/lean/luci-app-ttyd/po/zh-cn/terminal.po
sed -i 's/"USB 打印服务器"/"打印服务"/g' package/lean/luci-app-usb-printer/po/zh-cn/usb-printer.po
sed -i 's/"网络存储"/"存储"/g' package/lean/luci-app-usb-printer/po/zh-cn/usb-printer.po
sed -i 's/"Web 管理"/"Web"/g' package/lean/luci-app-webadmin/po/zh-cn/webadmin.po
sed -i 's/"管理权"/"改密码"/g' feeds/luci/modules/luci-base/po/zh-cn/base.po
sed -i 's/"带宽监控"/"监视"/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
# 修改luci/luci-app-ddns排序
find package/*/ feeds/*/ -maxdepth 5 -path "*luci-app-ddns/luasrc/controller/ddns.lua" | xargs -i sed -i 's/\"Dynamic DNS\")\, 59/\"Dynamic DNS\")\, 0/g' {}
# 修改luci-app-ddns导航菜单位置
find package/*/ feeds/*/ -maxdepth 8 -path "*luci-app-ddns/luasrc/controller/ddns.lua" | xargs -i sed -i 's/\"services\"/\"ddns\"/g' {}
find package/*/ feeds/*/ -maxdepth 8 -path "*luci-app-ddns/luasrc/model/cbi/ddns/detail.lua" | xargs -i sed -i 's/\"services\"/\"ddns\"/g' {}
find package/*/ feeds/*/ -maxdepth 8 -path "*luci-app-ddns/luasrc/model/cbi/ddns/global.lua" | xargs -i sed -i 's/\"services\"/\"ddns\"/g' {}
find package/*/ feeds/*/ -maxdepth 8 -path "*luci-app-ddns/luasrc/model/cbi/ddns/hints.lua" | xargs -i sed -i 's/\"services\"/\"ddns\"/g' {}
find package/*/ feeds/*/ -maxdepth 8 -path "*luci-app-ddns/luasrc/model/cbi/ddns/overview.lua" | xargs -i sed -i 's/\"services\"/\"ddns\"/g' {}
find package/*/ feeds/*/ -maxdepth 8 -path "*luci-app-ddns/luasrc/view/ddns/detail_logview.htm" | xargs -i sed -i 's/services/ddns/g' {}
find package/*/ feeds/*/ -maxdepth 8 -path "*luci-app-ddns/luasrc/view/ddns/overview_status.htm" | xargs -i sed -i 's/services/ddns/g' {}
find package/*/ feeds/*/ -maxdepth 8 -path "*luci-app-ddns/luasrc/view/ddns/system_status.htm" | xargs -i sed -i 's/services/ddns/g' {}
# 修改bypass排序
find package/*/ feeds/*/ -maxdepth 4 -path "*luci-app-bypass/luasrc/controller/bypass.lua" | xargs -i sed -i 's/\"Bypass\")\,2/\"Bypass\")\,0/g' {}
# 修改DNSFilter排序
# find package/*/ feeds/*/ -maxdepth 5 -path "*luci-app-dnsfilter/luasrc/controller/dnsfilter.lua" | xargs -i sed -i 's/\"DNSFilter\")\,0/\"DNSFilter\")\,3/g' {}
# 修改openclash排序
find package/*/ feeds/*/ -maxdepth 6 -path "*OpenClash/luci-app-openclash/luasrc/controller/openclash.lua" | xargs -i sed -i 's/\"OpenClash\")\, 50/\"OpenClash\")\, 1/g' {}
# 修改ShadowSocksR Plus+排序
find package/*/ feeds/*/ -maxdepth 6 -path "*helloworld/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua" | xargs -i sed -i 's/\"ShadowSocksR Plus+\")\, 10/\"ShadowSocksR Plus+\")\, 0/g' {}
# 修改GodProxy滤广告排序 重命名为:去TMD广告
find package/*/ feeds/*/ -maxdepth 6 -path "*luci-app-godproxy/luasrc/controller/koolproxy.lua" | xargs -i sed -i 's/\"GodProxy滤广告\")\,1/\"GodProxy滤广告\")\,10/g' {}
# 修改luci-app-smartdns排序 
find package/*/ feeds/*/ -maxdepth 6 -path "*luci-app-smartdns/luasrc/controller/smartdns.lua" | xargs -i sed -i 's/\"SmartDNS\")\, 4/\"SmartDNS\")\, 3/g' {}
# 修改甜糖心愿采集排序 
find package/*/ feeds/*/ -maxdepth 5 -path "*luci-app-ttnode/luasrc/controller/ttnode.lua" | xargs -i sed -i 's/0)\.dependent/50)\.dependent/g' {}
# 修改bypass支持lean源码重命名shadowsocksr-libev-ssr-redir
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
# 修改bypass支持lean源码重命名shadowsocksr-libev-ssr-server
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}
chmod +x scripts/*.sh
./scripts/preset-clash-core.sh amd64
./scripts/preset-terminal-tools.sh


