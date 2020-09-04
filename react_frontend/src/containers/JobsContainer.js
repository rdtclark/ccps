import React from 'react';
import JobList from '../components/JobList';

class JobsContainer extends React.Component {

    constructor(props){
        super(props);
        this.state = {
            jobs: []
        }
    }

    componentDidMount(){
        const job_url = 'http://localhost:3000/jobs'
        fetch(job_url)
        .then(res => res.json())
        .then(data => this.setState({jobs: data}))
    }

    render() {
        return(
            <div>
                <JobList jobs={this.state.jobs}/>
            </div>
        )
    }
}

export default JobsContainer;