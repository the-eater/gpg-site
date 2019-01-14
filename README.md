# gpg-site
Create a simple page which you can verify with GPG

Edit `html-body` and `html-template` to your liking and run `gen.sh ${KEYID}` after that you can verify it yourself by running

```
sed -e 's/<[^\[>]\+>//g' ./output.html | gpg -d
```
