import React, {Component} from "react";
import PartnersContainer from '../containers/PartnersContainer';
import JobsContainer from '../containers/JobsContainer';
import {BrowserRouter as Router, Route, Switch} from "react-router-dom";
import NavBar from '../components/NavBar';
import Home from '../components/Home';
import ErrorPage from '../components/ErrorPage';


class Main extends Component {
    constructor(props) {
        super(props);
        this.state = {

        }
    }


    render() {
        return (
            <Router>
                <React.Fragment>
                    <NavBar />
                    <Switch>
                        <Route exact path="/" component={Home}/>
                        <Route exact path="/organisations" component={PartnersContainer}/>
                        <Route exact path="/jobs" component={JobsContainer}/>
                        <Route component={ErrorPage}/>
                    </Switch>
                </React.Fragment>
            </Router>
        )
    }
}

export default Main; 