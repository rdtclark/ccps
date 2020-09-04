import React from 'react';
import Job from './Job';

const JobList = ({jobs}) => {

    const all_jobs = jobs.map(jobs => {

        return(
            <Job
            title={jobs.title}
            job_link={jobs.details_url}
            />
        )
    })

    return(

        <>
        <h2>Current Jerbs</h2>
        <ul>{all_jobs}</ul>
        </>
    )


}

export default JobList;