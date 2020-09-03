import React from 'react';
import OrganisationList from '../components/OrganisationList';

class PartnersContainer extends React.Component {

    constructor(props){
        super(props);
        this.state = {
            info: []
        }
    }

    componentDidMount(){
        const url = 'http://localhost:3000/organisations'
        fetch(url)
        .then(res => res.json())
        .then(data => this.setState({info: data}))
    }

    render() {
        return(
            <div>
                <OrganisationList info={this.state.info}/>
            </div>
        )
    }
}

export default PartnersContainer;