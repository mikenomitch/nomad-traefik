# Nomad & Traefik Webinar Files

These are the jobs deployed to Nomad in the (Nomad & Traefik webinar)[https://info.traefik.io/webinar-traefik-nomad-provider]:
* Traefik - Deployed as a system job and exposed on ports 80 (web) and 808 (admin UI).
* Outer - A service that curls an "inner" service and returns its contents.
* Inner - A service that reads environment variables and prints them.

These can be easily deployed onto a (Quick Nomad Stack on AWS)[https://github.com/mikenomitch/quick-nomad-stack].
