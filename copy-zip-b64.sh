touch exec
echo "#!/bin/bash" >> exec
echo "echo '{"hello": "hello"}'" >> exec

zip exec.zip exec
echo $(base64 exec.zip) | pbcopy

rm exec.zip
rm exec
