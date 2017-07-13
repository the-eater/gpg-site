#!/usr/bin/env bash
cd "$(dirname $0)";

if [ -z "${1}" ]; then
    echo "Missing GPG Key ID to sign body with";
    exit 1;
fi


PLAIN_BODY="$(echo -n "EOF" | cat ./html-body - | sed -e 's/<[^\[>]\+>//g')";
SIGNED_PLAIN_BODY="$(gpg -u "${1}" --clear-sign - <<< "${PLAIN_BODY%$'\n'EOF}")";
echo "$PLAIN_BODY";
SIGNED_HTML_BODY="$(php -r 'echo preg_replace("/(MESSAGE-----\s*\nHash: SHA256\s*\n).*(-----BEGIN)/s", "\\1" . file_get_contents(__DIR__ . "/html-body") . "\\2", stream_get_contents(STDIN));' <<< "$SIGNED_PLAIN_BODY")";
BODY="${SIGNED_HTML_BODY}";
eval 'echo "'"$(cat ./html-template)"'"' > ./output.html
echo "Done!";
