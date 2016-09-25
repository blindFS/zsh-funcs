function autoparen()
{
    LBUFFER+="("
    RBUFFER=")$RBUFFER"
}
zle -N autoparen autoparen

function autosingq()
{
    LBUFFER+="'"
    RBUFFER="'$RBUFFER"
}
zle -N autosingq autosingq

function autodoubq()
{
    LBUFFER+='"'
    RBUFFER='"'"$RBUFFER"
}
zle -N autodoubq autodoubq
