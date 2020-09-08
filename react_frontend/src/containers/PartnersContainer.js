import React from 'react';
import OrganisationList from '../components/OrganisationList';
import './PartnersContainer.css';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faLinkedin } from '@fortawesome/free-brands-svg-icons';
import { faPooStorm, faInfo, faBriefcase, faCheck, faTimesCircle } from '@fortawesome/free-solid-svg-icons';
import Table from 'react-bootstrap/Table';



class PartnersContainer extends React.Component {

    constructor(props){
        super(props);
        this.state = {
            org_info: []
        }
    }

    componentDidMount(){
        const org_url = 'http://localhost:3000/organisations'
        fetch(org_url)
        .then(res => res.json())
        .then(data => this.setState({org_info: data}))
    }

    

    renderTableData() {
        return this.state.org_info.map((org, index) => {
            const {id, organisation_name, homepage, about, job_page_url, linkedin, open_to_spec_app} = org
            const linkedin_icon = linkedin ? <FontAwesomeIcon icon={ faLinkedin }></FontAwesomeIcon> : null
            const open_to_spec = open_to_spec_app ? <FontAwesomeIcon icon={ faCheck }></FontAwesomeIcon> : null
            const job_url_icon = job_page_url ? <FontAwesomeIcon icon={ faBriefcase, faPooStorm }></FontAwesomeIcon> : null
            const abouticon = about ? <FontAwesomeIcon icon={ faInfo }></FontAwesomeIcon> : null

            return (
                <tr key={id} className="table">
                    <th className="col-width"><a href={homepage}>{organisation_name}</a></th>
                    <td id="tbody-center"><a href={about}>{abouticon}</a></td>
                    <td id="tbody-center"><a href={job_page_url}>{job_url_icon}</a></td>
                    <td id="tbody-center"><a href={linkedin}>{linkedin_icon}</a></td>
                    <td id="tbody-center">{open_to_spec}</td>
                </tr>
            )
        })
    }

    render() {
        return(
            <>
                <div>
                    <h2>
                        CodeClan_ Partners
                    </h2>
                    <Table hover>
                        <thead>
                            <tr>
                                <th>Organisation</th>
                                <th>About</th>
                                <th>Careers Page</th>
                                <th>LinkedIn</th>
                                <th>Open to Email</th>
                            </tr>
                        </thead>
                        <tbody>
                            {this.renderTableData()}
                        </tbody>
                    </Table>
                </div>
            </>
        )
    }
}

export default PartnersContainer;
