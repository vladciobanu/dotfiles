#!/run/current-system/sw/bin/bash

notmuch new --quiet
res=$(notmuch count tag:unread folder:'gmail/Inbox')

echo $res

exit 0