# cname-check
 Check if the subdomains have cnames to the same tld or 3rd party service

### Usage:

bash cname.sh subdomain_file

or

chmod +x cname.sh
./cname.sh subdomain_file

The output will be 3 different files:
1. no_cname: Subdomains with No CNAMEs
2. host_match: Subdomains with same tld as CNAME, ideally redirects to same host
3. cname_out: Subdomains pointing to 3rd party services/CNAMEs