# wget2-windows

## 下载

请到Action页面下载构建好的二进制文件使用:`https://github.com/ibook86/wget2-windows/actions/workflows/build.yml`

```shell
GNU Wget2 V2.0.0 - multithreaded metalink/file/website downloader

Usage: wget [options...] <url>...

Startup:
  -a  --append-output       File where messages are appended to, '-' for STDOUT
  -b  --background          Go to background immediately after startup. If no
                              output file is specified via the -o, output is redirected to wget-log
  -B  --base                Base for relative URLs read from input-file
                              or from command line
      --config              Path to initialization file (default: ~/.config/wget/wget2rc)
  -d  --debug               Print debugging messages.(default: off)
  -e  --execute             Wget compatibility option, not needed for Wget
      --force-atom          Treat input file as Atom Feed. (default: off) (NEW!)
      --force-css           Treat input file as CSS. (default: off) (NEW!)
  -F  --force-html          Treat input file as HTML. (default: off)
      --force-metalink      Treat input file as Metalink. (default: off) (NEW!)
      --force-rss           Treat input file as RSS Feed. (default: off) (NEW!)
      --force-sitemap       Treat input file as Sitemap. (default: off) (NEW!)
      --fsync-policy        Use fsync() to wait for data being written to
                              the pysical layer. (default: off) (NEW!)
  -h  --help                Print this help.
      --hyperlink           Enable terminal hyperlink support
      --input-encoding      Character encoding of the file contents read with
                              --input-file. (default: local encoding)
  -i  --input-file          File where URLs are read from, - for STDIN.
      --local-db            Read or load databases
  -o  --output-file         File where messages are printed to,
                              '-' for STDOUT.
  -q  --quiet               Print no messages except debugging messages.
                              (default: off)
      --stats-dns           Print DNS stats. (default: off)
                              Additional format supported:
                              --stats-dns=[FORMAT:]FILE
      --stats-ocsp          Print OCSP stats. (default: off)
                              Additional format supported:
                              --stats-ocsp=[FORMAT:]FILE
      --stats-server        Print server stats. (default: off)
                              Additional format supported:
                              --stats-server=[FORMAT:]FILE
      --stats-site          Print site stats. (default: off)
                              Additional format supported:
                              --stats-site=[FORMAT:]FILE
      --stats-tls           Print TLS stats. (default: off)
                              Additional format supported:
                              --stats-tls=[FORMAT:]FILE
      --unlink              Remove files before clobbering. (default: off)
  -v  --verbose             Print more messages. (default: on)
  -V  --version             Display the version of Wget and exit.

Download:
  -A  --accept              Comma-separated list of file name suffixes or
                              patterns.
      --accept-regex        Regex matching accepted URLs.
      --ask-password        Print prompt for password
      --backups             Make backups instead of overwriting/increasing
                              number. (default: 0)
      --bind-address        Bind to sockets to local address.
                              (default: automatic)
      --bind-interface      Bind sockets to the input Network Interface.
                              (default: automatic)
      --body-data           Data to be sent in a request.
      --body-file           File with data to be sent in a request.
      --cache               Enabled using of server cache. (default: on)
      --chunk-size          Download large files in multithreaded chunks.
                              (default: 0 (=off)) Example:
                              wget --chunk-size=1M
      --clobber             Enable file clobbering. (default: on)
      --connect-timeout     Connect timeout in seconds.
      --content-on-error    Save response body even on error status.
                              (default: off)
  -c  --continue            Continue download for given files. (default: off)
      --convert-file-only   Convert only filename part of embedded URLs.
                              (default: off)
  -k  --convert-links       Convert embedded URLs to local URLs.
                              (default: off)
      --cut-file-get-vars   Cut HTTP GET vars from file names. (default: off)
      --cut-url-get-vars    Cut HTTP GET vars from URLs. (default: off)
      --delete-after        Don't save downloaded files. (default: off)
      --dns-cache           Caching of domain name lookups. (default: on)
      --dns-cache-preload   File to be used to preload the DNS cache.
                              Format is like /etc/hosts (IP<whitespace>hostname).
      --dns-timeout         DNS lookup timeout in seconds.
  -D  --domains             Comma-separated list of domains to follow.
      --download-attr       Recognize HTML5 download attributes.
                              'strippath' strips the path to be more secure.
'usepath' uses the path as is (this can be extremely dangerous !).
(default: strippath)
  -X  --exclude-directories
                            Comma-separated list of directories NOT to download.
                              Wildcards are allowed.
      --exclude-domains     Comma-separated list of domains NOT to follow.
      --filter-mime-type    Specify a list of mime types to be saved or ignored
      --filter-urls         Apply the accept and reject filters on the URL
                              before starting a download. (default: off)
      --follow-tags         Scan additional tag/attributes for URLs,
                              e.g. --follow-tags="img/data-500px,img/data-hires
      --force-progress      Force progress bar.
                              (default: off)
      --http2-request-window
                            Max. number of parallel streams per HTTP/2
                              connection. (default: 30)
      --if-modified-since   Do not send If-Modified-Since header in -N mode.
Send preliminary HEAD request instead. This has only
                              effect in -N mode.
      --ignore-case         Ignore case when matching files. (default: off)
      --ignore-length       Ignore content-length header field
                              (default: off)
      --ignore-tags         Ignore tag/attributes for URL scanning,
                              e.g. --ignore-tags="img,a/href
  -I  --include-directories
                            Comma-separated list of directories TO download.
                              Wildcards are allowed.
  -4  --inet4-only          Use IPv4 connections only. (default: off)
  -6  --inet6-only          Use IPv6 connections only. (default: off)
      --iri                 Wget dummy option, you can't switch off
                              international support
      --keep-extension      If file exists: Use pattern 'basename_N.ext'
                              instead of 'filename.N'. (default: off)
  -l  --level               Maximum recursion depth. (default: 5)
      --local-encoding      Character encoding of environment and filenames.
      --max-redirect        Max. number of redirections to follow.
                              (default: 20)
      --max-threads         Max. concurrent download threads.
                              (default: 5) (NEW!)
  -m  --mirror              Turn on mirroring options -r -N -l inf
      --netrc               Load credentials from ~/.netrc if not given.
                              (default: on)
  -O  --output-document     File where downloaded content is written to,
                              '-O'  for STDOUT.
  -p  --page-requisites     Download all necessary files to display a
                              HTML page
      --parent              Ascend above parent directory. (default: on)
      --password            Password for Authentication.
                              (default: empty password)
      --post-data           Data to be sent in a POST request.
      --post-file           File with data to be sent in a POST request.
      --prefer-family       Prefer IPv4 or IPv6. (default: none)
      --progress            Type of progress bar (bar, none).
                              (default: none)
      --proxy               Enable support for *_proxy environment variables.
                              (default: on)
      --random-wait         Wait 0.5 up to 1.5*<--wait> seconds between
                              downloads (per thread). (default: off)
      --read-timeout        Read and write timeout in seconds.
  -r  --recursive           Recursive download. (default: off)
      --regex-type          Regular expression type. This build only supports
                              posix. (default: posix)
  -R  --reject              Comma-separated list of file name suffixes or
                              patterns.
      --reject-regex        Regex matching rejected URLs.
      --remote-encoding     Character encoding of remote files
                              (if not specified in Content-Type HTTP header
                              or in document itself)
      --report-speed        Output bandwidth as TYPE. TYPE can be bytes
                              or bits. --progress MUST be used.
      --restrict-file-names
                            unix, windows, nocontrol, ascii, lowercase,
                              uppercase, none
      --retry-on-http-error
                            Specify a list of http statuses in which the download will be retried
      --robots              Respect robots.txt standard for recursive
                              downloads. (default: on)
      --save-content-on     Specify a list of response codes that requires it's
                              response body to be saved on error status
  -S  --server-response     Print the server response headers. (default: off)
  -H  --span-hosts          Span hosts that were not given on the
                              command line. (default: off)
      --spider              Enable web spider mode. (default: off)
      --start-pos           Start downloading at zero-based position, 0 = option disabled. (default: 0)
      --strict-comments     A dummy option. Parsing always works non-strict.
      --tcp-fastopen        Enable TCP Fast Open (TFO). (default: on)
  -T  --timeout             General network timeout in seconds.
  -N  --timestamping        Just retrieve younger files than the local ones.
                              (default: off)
  -t  --tries               Number of tries for each download. (default 20)
      --trust-server-names  On redirection use the server's filename.
                              (default: off)
      --use-askpass         Prompt for a user and password using
                              the specified command.
      --use-server-timestamps
                            Set local file's timestamp to server's timestamp.
                              (default: on)
      --user                Username for Authentication.
                              (default: empty username)
  -w  --wait                Wait number of seconds between downloads
                              (per thread). (default: 0)
      --waitretry           Wait up to number of seconds after error
                              (per thread). (default: 10)
      --xattr               Save extended file attributes. (default: off)

HTTP related options:
  -E  --adjust-extension    Append extension to saved file (.html or .css).
                              (default: off)
      --auth-no-challenge   send Basic HTTP Authentication before challenge
  -K  --backup-converted    When converting, keep the original file with
                              a .orig suffix. (default: off)
      --compression         Customize Accept-Encoding with
                              identity, gzip, deflate, xz, lzma, br, bzip2, zstd, lzip
                              and any combination of it
                              no-compression means no Accept-Encoding
      --content-disposition
                            Take filename from Content-Disposition.
                              (default: off)
      --cookie-suffixes     Load public suffixes from file.
                              They prevent 'supercookie' vulnerabilities.
                              See https://publicsuffix.org/ for details.
      --cookies             Enable use of cookies. (default: on)
      --default-http-port   Set default port for HTTP. (default: 80)
      --default-https-port  Set default port for HTTPS. (default: 443)
      --default-page        Default file name. (default: index.html)
      --header              Insert input string as a HTTP header in
                              all requests
      --html-extension      Obsoleted by --adjust-extension
      --http-keep-alive     Keep connection open for further requests.
                              (default: on)
      --http-password       Password for HTTP Authentication.
                              (default: empty password)
      --http-proxy          Set HTTP proxy/proxies, overriding environment
                              variables. Use comma to separate proxies.
      --http-proxy-password
                            Password for HTTP Proxy Authentication.
                              (default: empty password)
      --http-proxy-user     Username for HTTP Proxy Authentication.
                              (default: empty username)
      --http-user           Username for HTTP Authentication.
                              (default: empty username)
      --keep-session-cookies
                            Also save session cookies. (default: off)
      --limit-rate          Limit rate of download per second, 0 = no limit. (default: 0)
      --load-cookies        Load cookies from file.
      --metalink            Follow a metalink file instead of storing it
                              (default: on)
      --method              HTTP method to use for request.
      --netrc-file          Set file for login/password to use instead of
                              ~/.netrc. (default: ~/.netrc)
  -Q  --quota               Download quota, 0 = no quota. (default: 0)
      --referer             Include Referer: url in HTTP request.
                              (default: off)
      --retry-connrefused   Consider "connection refused" a transient error.
                               (default: off)
      --save-cookies        Save cookies to file.
      --save-headers        Save the response headers in front of the response
                              data. (default: off)
  -U  --user-agent          HTTP User Agent string.
                              (default: wget)

HTTPS (SSL/TLS) related options:
      --ca-certificate      File with bundle of PEM CA certificates.
      --ca-directory        Directory with PEM CA certificates.
      --certificate         File with client certificate.
      --certificate-type    Certificate type: PEM or DER (known as ASN1).
                              (default: PEM)
      --check-certificate   Check the server's certificate. (default: on)
      --check-hostname      Check the server's certificate's hostname.
                              (default: on)
      --crl-file            File with PEM CRL certificates.
      --egd-file            File to be used as socket for random data from
                              Entropy Gathering Daemon.
      --hpkp                Use HTTP Public Key Pinning (HPKP). (default: on)
      --hpkp-file           Set file for storing HPKP data
                              (default: ~/.wget-hpkp)
      --hsts                Use HTTP Strict Transport Security (HSTS).
                              (default: on)
      --hsts-file           Set file for HSTS caching. (default: ~/.wget-hsts)
      --hsts-preload        Use HTTP Strict Transport Security (HSTS).
                              [Not built with libhsts, so not functional]
      --hsts-preload-file   Set name for the HSTS Preload file (DAFSA format).
                              [Not built with libhsts, so not functional]
      --http2               Use HTTP/2 protocol if possible. (default: on)
      --http2-only          Only use HTTP/2 protocol, error if server doesn't offer it. (default: off)
      --https-enforce       Use secure HTTPS instead of HTTP. Legal types are
                              'hard', 'soft' and 'none'.
                              If --https-only is enabled,
                              this option has no effect. (default: none)
      --https-only          Do not follow non-secure URLs. (default: off).
      --https-proxy         Set HTTPS proxy/proxies, overriding environment
                              variables. Use comma to separate proxies.
      --ocsp                Use OCSP server access to verify server's
                              certificate. (default: on)
      --ocsp-date           Check if OCSP response date is too old.
                              (default: on)
      --ocsp-file           Set file for OCSP chaching.
                              (default: ~/.wget-ocsp)
      --ocsp-nonce          Allow nonce checking when verifying OCSP
                              response. (default: on)
      --ocsp-server         Set OCSP server address.
                              (default: OCSP server given in certificate)
      --ocsp-stapling       Use OCSP stapling to verify the server's
                              certificate. (default: on)
      --private-key         File with private key.
      --private-key-type    Type of the private key (PEM or DER).
                              (default: PEM)
      --random-file         File to be used as source of random data.
      --secure-protocol     Set protocol to be used (auto, SSLv3, TLSv1, TLSv1_1, TLSv1_2, TLS1_3, PFS).
                              (default: auto). Or use GnuTLS priority
                              strings, e.g. NORMAL:-VERS-SSL3.0:-RSA
      --tls-false-start     Enable TLS False Start (needs GnuTLS 3.5+).
                              (default: on)
      --tls-resume          Enable TLS Session Resumption. (default: off)
      --tls-session-file    Set file for TLS Session caching.
                              (default: ~/.wget-session)

Directory options:
      --cut-dirs            Skip creating given number of directory
                              components. (default: 0)
      --directories         Create hierarchy of directories when retrieving
                              recursively. (default: on)
  -P  --directory-prefix    Set directory prefix.
  -x  --force-directories   Create hierarchy of directories when not
                              retrieving recursively. (default: off)
      --host-directories    Create host directories when retrieving
                              recursively. (default: on)
      --protocol-directories
                            Force creating protocol directories.
                              (default: off)

Plugin options:
      --list-plugins        Lists all the plugins in the plugin search paths.
      --local-plugin        Loads a plugin with a given path.
      --plugin              Load a plugin with a given name.
      --plugin-dirs         Specify alternative directories to look
                              for plugins, separated by ','
      --plugin-help         Print help message for all loaded plugins
      --plugin-opt          Forward an option to a loaded plugin.
                              The option should be in format:
                              <plugin_name>.<option>[=value]


Example boolean option:
 --quiet=no is the same as --no-quiet or --quiet=off or --quiet off
Example string option:
 --user-agent=SpecialAgent/1.3.5 or --user-agent "SpecialAgent/1.3.5"

To reset string options use --[no-]option
```