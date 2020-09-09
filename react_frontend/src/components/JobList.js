import React from 'react';
import Job from './Job';
import Badge from 'react-bootstrap/Badge';


const JobList = ({jobs}) => {

    let all_tags = []
    const all_jobs = jobs.map(job => {
        
        const tags = job.title.match(/\S+\s*/g);
        all_tags.push(tags);

        return(
            <Job
            title={job.title}
            job_link={job.details_url}
            />
        ) 
    })
    console.log(all_tags.flat());



    return(

        <>
        <h2>Current Jerbs <Badge pill variant="info">{all_jobs.length}</Badge></h2>
        <ul>{all_jobs}</ul>
        </>
    )


}

export default JobList;