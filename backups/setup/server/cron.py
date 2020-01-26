"""
Setup cron jobs for database backups.

See https://www.freeformatter.com/cron-expression-generator-quartz.html
"""
import sys

import click
from crontab import CronTab

cron = CronTab(user="ubuntu")


@click.group()
def cli():
    """
    CRON CLI
    """
    pass


@click.command()
@click.argument("script_path")
def add(script_path):
    existing_jobs = _find_jobs(script_path)
    _remove_jobs(existing_jobs)

    # Run every day at the start of the day
    job = cron.new(command=f"bash {script_path}")
    job.minute.on(0)
    job.hour.on(0)
    print("New job created:", job)
    print("Job executions per year: ", job.frequency())
    assert job.is_valid(), "Job is not valid"
    cron.write()


@click.command()
@click.argument("script_path")
def remove(script_path):
    existing_jobs = _find_jobs(script_path)
    _remove_jobs(existing_jobs)


@click.command()
def view():
    print("\nCron jobs:\n")
    for job in cron:
        print("\t", job)

    print()


def _remove_jobs(jobs):
    for job in jobs:
        cron.remove(job)
        cron.write()


def _find_jobs(script_path):
    return list(cron.find_command(script_path))


cli.add_command(add)
cli.add_command(remove)
cli.add_command(view)
cli()
