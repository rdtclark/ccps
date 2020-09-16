import React from 'react';
import JobFilter from '../components/JobFilter';
import JobList from '../components/JobList';
import './JobsContainer.css'

class JobsContainer extends React.Component {

    constructor(props){
        super(props);
        this.state = {
            jobs: [],
            filteredJobs: []
        }
    }

    componentDidMount(){
        const job_url = 'http://localhost:3000/jobs'
        fetch(job_url)
        .then(res => res.json())
        .then(data => this.setState({jobs: data}))
    }
    
    // test(){
    //     this.setState({
    //         jobs,
    //         filteredJobs: jobs
    //     })
    // }

    filterJobs = (jobFilter) => {
        let filteredJobs = this.state.jobs
        filteredJobs = filteredJobs.filter((job) => {
            let jobName = job.title.toLowerCase()
            return jobName.indexOf(
                jobFilter.toLowerCase()) !== -1
        })
        this.setState({
            filteredJobs
        })
    }

    render() {
        return(
            <div>
                {/* <JobFilter jobs={this.state.filteredJobs} match={this.props.match} onChange={this.filterJobs}></JobFilter> */}

                <JobList jobs={this.state.jobs}/>
            </div>
        )
    }
}

export default JobsContainer;