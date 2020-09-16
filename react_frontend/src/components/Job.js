import React from 'react';

const Job = ({title, job_link, org_name, loc}) => {

    return (
        <>
        <li className="no-blt"><b>{org_name}</b> <a href={job_link} target="_blank" className="btn-r" id="button"><span>View Job</span></a>
        <div className="subtext">{title}</div>
        <div className="subtext-loc">{loc}</div>
        </li>
        </>
    )
}

export default Job;