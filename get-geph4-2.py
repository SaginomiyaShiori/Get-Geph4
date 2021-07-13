import os
import requests

localFile='geph4Version'

geph4Version=requests.get('https://api.github.com/repos/geph-official/geph4/tags').json()[0]['name']
print(geph4Version)

if os.path.exists(localFile):
    if open(localFile).read() == geph4Version:
        print("Already the latest version")
    else:
        f=open(localFile,'w')
        f.write(geph4Version)
        f.close()
        os.system("git add -A && git commit -am 'update to %s' && git tag %s" %(geph4Version,geph4Version))
        os.system("git push && git push origin --tags")