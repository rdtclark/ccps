import React from 'react';
import Job from './Job';




const JobList = ({jobs}) => {

    let all_tags = []
    const all_jobs = jobs.map(job => {
        
        const tags = job.title.match(/\S+\s*/g);
        all_tags.push(tags);

        return(
            <Job
            title={job.title}
            job_link={job.details_url}
            org_name={job.organisation_name}
            loc={job.location}
            />
        ) 
    })
    console.log(all_tags.flat());



    return(

        <>
        <div>
        <h1 className="title-in">Jobs</h1>
        <sup><button id="counter"><b>{all_jobs.length}</b></button></sup>
        </div>
        <ul>{all_jobs}</ul>
        </>
    )


}

export default JobList;