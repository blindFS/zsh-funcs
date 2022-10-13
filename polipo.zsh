socks_proxy()
{
    if (( $+http_proxy )); then
        unset http_proxy
        unset https_proxy
        echo "disabled"
    else
        export http_proxy=http://localhost:7890
        export https_proxy=http://localhost:7890
        echo "enabled"
    fi
}
