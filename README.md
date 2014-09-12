## Django Images

This repository creates [Django of busybox images](https://github.com/grengojbo/docker-django) with full-chains from scratch using [Buildroot](http://buildroot.uclibc.org). 

This image size **281 mb**.

Available via `docker pull grengojbo/django:latest`. [Example](https://github.com/grengojbo/docker-django/tree/master/example) project files.

* Python (2.7.6)
    * Wide MySQL support
    * easy_install (setuptools 5.7)
    * pip (1.5.6)
* Django (1.5.9)
    * Pillow (2.5.3) png, jpeg support
    * [List of all packages](https://github.com/grengojbo/docker-django/blob/master/tarmaker/freeze.txt)
* Bash (4.3)
* System
    * Wide character support
* Internet/networking
    * IPV4, IPV6
* Curl (7.35.0)/libcurl (7.35.0), built with OpenSSL (1.0.1f, includes
  ca-certificates), zlib (1.2.8), and Libssh2 (1.4.3)
    * Protocols: dict file ftp ftps gopher http https imap imaps pop3 pop3s rtsp
      scp sftp smtp smtps telnet tftp 
    * Features: IPv6 Largefile NTLM SSL libz TLS-SRP
* Git (1.8.3.5)
    * built with OpenSSL (1.0.1f, includes ca-certificates) and zlib (1.2.8) 
    * Protocols: local, git, http, https, (no SSH)
        * This build is made for importing repositories securely, so the above
          protocols will work for `git clone` and `git fetch` for example but
          will be lacking if you attempt a standard workflow (cannot push new
          commits securly to remote server).
    * This is a bare minimum package made to support all the core git functions
      as found in `git --help`.  All other tools and extras found in the git
      suite have been stripped to keep the image size to a minimum. Additional
      git features such as the server backends, cvs and shell login, svn
      support, and some others can be easily added back in at a cost of about
      0.5 - 1mb of image size per item. Feel free to reach out with requests for
      custom git builds.

The git image is default [Hub container][hub_cont] image and weighs in at around
281 mb. Hub containers have the ability to access other
containers/servers/web-locations to grab and update configuration using git
and/or cURL. The possibilities are pretty extensive!

[hub_cont]: https://registry.hub.docker.com/u/grengojbo/django/

### Source

The tarbuilders used to create these images can be found [here][repo]

[repo]: https://github.com/grengojbo/docker-django
