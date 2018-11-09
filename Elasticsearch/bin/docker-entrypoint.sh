#!/bin/bash
set -e

# Files created by Elasticsearch should always be group writable too
umask 0002


# allow the container to be started with `--user`
# all commands should be dropped to the correct user
if [ "$(id -u)" = '0' ]; then
   chown -R elasticsearch:elasticsearch /elasticsearch/data /elasticsearch/logs
#   exec gosu elasticsearch "$BASH_SOURCE" "$@"
fi

# Allow user specify custom CMD, maybe bin/elasticsearch itself
# for example to directly specify `-E` style parameters for elasticsearch on k8s
# or simply to run /bin/bash to check the image
#if [[ "$1" != "eswrapper" ]]; then
#    if [[ "$(id -u)" == "0" && $(basename "$1") == "elasticsearch" ]]; then
#        # centos:7 chroot doesn't have the `--skip-chdir` option and
        # changes our CWD.
        # Rewrite CMD args to replace $1 with `elasticsearch` explicitly,
        # so that we are backwards compatible with the docs
        # from the previous Elasticsearch versions<6
        # and configuration option D:
        # https://www.elastic.co/guide/en/elasticsearch/reference/5.6/docker.html#_d_override_the_image_8217_s_default_ulink_url_https_docs_docker_com_engine_reference_run_cmd_default_command_or_options_cmd_ulink
        # Without this, user could specify `elasticsearch -E x.y=z` but
        # `bin/elasticsearch -E x.y=z` would not work.
 #       set -- "elasticsearch" "${@:2}"
        # Use chroot to switch to UID 1000
#        exec chroot --userspec=1000 / "$@"
#    else
        # User probably wants to run something else, like /bin/bash, with another uid forced (Openshift?)
#        exec "$@"
#    fi
#fi

# Parse Docker env vars to customize Elasticsearch
#
# e.g. Setting the env var cluster.name=testcluster
#
# will cause Elasticsearch to be invoked with -Ecluster.name=testcluster
#
# see https://www.elastic.co/guide/en/elasticsearch/reference/current/settings.html#_setting_default_settings

declare -a es_opts

while IFS='=' read -r envvar_key envvar_value
do
    # Elasticsearch env vars need to have at least two dot separated lowercase words, e.g. `cluster.name`
    if [[ "$envvar_key" =~ ^[a-z0-9_]+\.[a-z0-9_]+ ]]; then
        if [[ ! -z $envvar_value ]]; then
          es_opt="-E${envvar_key}=${envvar_value}"
          es_opts+=("${es_opt}")
        fi
    fi
done < <(env)

# add additional parameters in the main  config file
# if ! grep -q '# AUTO_ADDITIONAL_PARAMETERS' /usr/share/elasticsearch/config/elasticsearch.yml
# then
#    echo -e "# AUTO_ADDITIONAL_PARAMETERS" >> /usr/share/elasticsearch/config/elasticsearch.yml
#    echo -e ${ADD_PARAMETERS_IN_MAIN_CONFIG} >> /usr/share/elasticsearch/config/elasticsearch.yml
# fi

# The virtual file /proc/self/cgroup should list the current cgroup
# membership. For each hierarchy, you can follow the cgroup path from
# this file to the cgroup filesystem (usually /sys/fs/cgroup/) and
# introspect the statistics for the cgroup for the given
# hierarchy. Alas, Docker breaks this by mounting the container
# statistics at the root while leaving the cgroup paths as the actual
# paths. Therefore, Elasticsearch provides a mechanism to override
# reading the cgroup path from /proc/self/cgroup and instead uses the
# cgroup path defined the JVM system property
# es.cgroups.hierarchy.override. Therefore, we set this value here so
# that cgroup statistics are available for the container this process
# will run in.
export ES_JAVA_OPTS="-Des.cgroups.hierarchy.override=/ $ES_JAVA_OPTS"

exec gosu elasticsearch /usr/share/elasticsearch/bin/elasticsearch "${es_opts[@]}"

