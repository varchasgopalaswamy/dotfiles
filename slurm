#slurm
alias sq='squeue -u $USER'
alias sqw='watch squeue -u $USER'
alias sqa='squeue'
alias sb='sbatch'
alias sc='scancel'
alias si='sinfo -o "%.18P %.5T %.10m %.10d %.10G %.20N"'
alias sme='sacct -u $USER -S $(date +%F)'
# Basic version
alias sint='srun --pty /bin/bash -l'

# A more customized example:
# alias sint='srun --pty -p debug -A my_account -t 01:00:00 --mem=8G /bin/bash -l'

# Usage: sjob 123456
sjob() {
    sacct -j $1 -o JobID,JobName,State,ExitCode,MaxRSS,Elapsed
}
# Usage: stail 123456
stail() {
    if [ -z "$1" ]; then
        echo "Usage: stail <JobID>"
        return 1
    fi

    # Get the full path to the standard output file
    local outfile=$(scontrol show job $1 | awk -F= '/StdOut=/{print $2}')

    if [ -z "$outfile" ]; then
        echo "Could not find StdOut file for job $1."
        echo "Is the job running or has it finished?"
    elif [ "$outfile" == "standard output" ]; then
        echo "Job $1 is using standard output (likely in your terminal)."
    elif [ ! -f "$outfile" ]; then
        echo "Waiting for output file to be created..."
        echo "Tailing: $outfile"
        # Loop until the file appears, then tail
        while [ ! -f "$outfile" ]; do sleep 1; done
        tail -f "$outfile"
    else
        echo "Tailing: $outfile"
        tail -f "$outfile"
    fi
}




