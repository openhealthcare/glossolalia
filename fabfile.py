from fabric.api import env, task, local, cd
from fabric.operations import prompt, put, run
from fabric.context_managers import warn_only
import os


env.hosts = ["ec2-52-31-226-37.eu-west-1.compute.amazonaws.com"]
env.user = "ubuntu"
project_name = "glossolalia"
fabfile_dir = os.path.realpath(os.path.dirname(__file__))


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
def build():
    with cd("~/{}".format(project_name)):
        local("MIX_ENV=prod mix phoenix.digest")
        local("mix hex.info")
        local("mix deps.get")
        local("MIX_ENV=prod mix release mix release --verbosity=verbose")


@task
def build_remote_server(key_file_name="../ec2.pem"):
    remote_user = env.user
    playbook = "provision/playbooks/staging_server.yml"
    hosts = "provision/playbooks/hosts.yml"
    command = "ansible-playbook --private-key {0} -i {1} -u {2} {3}"
    command = command.format(key_file_name, hosts, remote_user, playbook)
    local(command)


@task
def build_test_server():
    playbook = "provision/playbooks/test_server.yml"
    command = 'ansible-playbook -i "localhost," -c local {}'.format(playbook)
    local(command)


@task
def release(key_file_name="../ec2.pem"):
    env.key_filename = key_file_name
    with warn_only():
        run("rm -rf glossolalia")

    run("mkdir glossolalia")

    put(
        local_path=os.path.join(
            fabfile_dir, "rel/glossolalia/releases/0.0.1/glossolalia.tar.gz"
        ),
        remote_path="/home/ubuntu/glossolalia"
    )
    with cd("/home/ubuntu/glossolalia"):
        run("tar -xvf glossolalia.tar.gz")

@task
def deploy(key_file_name="../ec2.pem"):
    if check_for_uncommitted():
        build()
        build_remote_server()
        release(key_file_name)
