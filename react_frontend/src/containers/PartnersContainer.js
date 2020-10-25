import React from 'react';
import './PartnersContainer.css';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faLinkedin } from '@fortawesome/free-brands-svg-icons';
import { faInfo, faBriefcase, faCheck } from '@fortawesome/free-solid-svg-icons';
import { API_BASE_URL } from '../constants';


class PartnersContainer extends React.Component {

    constructor(props){
        super(props);
        this.state = {
            org_info: [],
            // employersWithVacancies: {}
        }
    }

    componentDidMount(){
        const org_url = API_BASE_URL + "/organisations"
        fetch(org_url)
        .then(res => res.json())
        .then(data => this.setState({org_info: data}))
    }

    
    calculateEmployersWithVacancies() {
        let counter = 0

        return this.state.org_info.map(org => {
            const {vacancies_listed} = org
            
            if (vacancies_listed === true) {
                return counter += 1
            } else {
                return counter += 0
            }
        })
    }





    renderTableData() {
        return this.state.org_info.map((org, index) => {
            const {id, organisation_name, homepage, about, job_page_url, linkedin, open_to_spec_app} = org


            // saving icons as variables so the table content in the return is easier to read
            const linkedin_icon = linkedin ? <FontAwesomeIcon icon={ faLinkedin }></FontAwesomeIcon> : null
            const open_to_spec = open_to_spec_app ? <FontAwesomeIcon icon={ faCheck }></FontAwesomeIcon> : null
            const job_url_icon = job_page_url ? <FontAwesomeIcon icon={ faBriefcase }></FontAwesomeIcon> : null
            const about_icon = about ? <FontAwesomeIcon icon={ faInfo }></FontAwesomeIcon> : null

            return (
                <tr key={id} className="table">

                    <th className="col-width">
                        <a href={homepage} target="_blank" rel="noopener noreferrer">{organisation_name}</a>
                        {/* <sup><button id="counter"><b>{all_jobs.length}</b></button></sup> */}
                    </th>

                    <td id="tbody-center"><a href={about} target="_blank" rel="noopener noreferrer">{about_icon}</a></td>
                    <td id="tbody-center"><a href={job_page_url} target="_blank" rel="noopener noreferrer">{job_url_icon}</a></td>
                    <td id="tbody-center"><a href={linkedin} target="_blank" rel="noopener noreferrer">{linkedin_icon}</a></td>
                    <td id="tbody-center">{open_to_spec}</td>
                </tr>
            )
        })
    }

    render() {
        return(
            <>
                <div>
                    <h1 className="title-in">
                         Employers {/*{this.calculateEmployersWithVacancies()} */}
                    </h1>
                    <table className="table-pos">
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
                    </table>
                </div>
            </>
        )
    }
}

export default PartnersContainer;
