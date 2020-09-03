import React from 'react';

const Organisation = ({name, homepage, about}) => {

    return (
        <>
        <li><a href={homepage}>{name}</a> | <a href={about}>About</a></li>
        </>
    )
}

export default Organisation;