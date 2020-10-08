import React, { Component} from 'react';

class JobFilter extends Component {
    constructor(props) {
        super(props)
        this.state = {
            jobFilter: ""
        }
    }

    handleChange = (e) => {
        this.setState({
            jobFilter: e.target.value
        })
        this.props.onChange(e.target.value)
    }

    render() {
        return (
            <div>
                <label htmlFor="filter">Filter by Job: </label>
                <input type="text" id="filter"
                value={this.state.jobFilter}
                onChange={this.handleChange}/>
            </div>
        )
    }
}

export default JobFilter;