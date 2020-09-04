import React from 'react';
import Organisation from './Organisation';

const OrganisationList = ({info}) => {

    const all_info = info.map(info => {

        return (
            <Organisation
            name={info.organisation_name}
            homepage={info.homepage}
            about={info.about}/>
        )
    })

    return(
        <>
        <ul>{all_info}</ul>
        </>
    )
}

export default OrganisationList;