import React from 'react';

const Job = ({title, job_link, org_name, loc}) => {

    return (
        <>
        <li className="no-blt"><b>{org_name}</b> <a href={job_link} target="_blank"><button className="btn-r" id="button">View Job</button></a>
        <div className="subtext">{title}</div>
        <div className="subtext-loc">{loc}</div>
        </li>
        </>
    )
}

export default Job;