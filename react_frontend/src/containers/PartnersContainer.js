import React from 'react';
import OrganisationList from '../components/OrganisationList';

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

    render() {
        return(
            <div>
                <OrganisationList org_info={this.state.org_info}/>
            </div>
        )
    }
}

export default PartnersContainer;