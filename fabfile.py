from fabric.api import env, task, run, local, cd
from fabric.operations import prompt
from fabric.contrib.project import upload_project


env.hosts = ["elcid-uch-test.openhealthcare.org.uk"]
env.user = "ubuntu"
project_name = "glossolalia"


def check_for_uncommitted():
    changes = local("git status --porcelain", capture=True)

    if len(changes):
        print " {}".format(changes)
        proceed = prompt(
            "you have uncommited changes, do you want to proceed",
            default=False,
            validate=bool
        )

        return proceed
    else:
        return True


@task
def deploy(key_file_name="../ec2.pem"):
    env.key_filename = key_file_name

    # if check_for_uncommitted():
    with cd("~/{}".format(project_name)):
        local("MIX_ENV=prod mix phoenix.digest")
        local("MIX_ENV=prod mix release")
        upload_project(
            remote_dir="/home/ubuntu/glossolalia-new",
            local_dir="/usr/lib/ohc/glossolalia/rel/glossolalia/"
        )
