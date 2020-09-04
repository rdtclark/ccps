import React from 'react';

const Job = ({title, job_link}) => {

    return (
        <>
        <li><a href={job_link}>{title}</a></li>
        </>
    )
}

export default Job;