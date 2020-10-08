import React from "react";
import { Link } from "react-router-dom";
import './NavBar.css';


const NavBar = () => (
    
    <div className="navbar-position">
        {/* <div>
            <Link to="/">Home</Link>
        </div>
        | */}
        <div>
            <h1 id="router-links">
            <Link to="/organisations">Organisations </Link>  
        |
            <Link to="/jobs"> Job List</Link>
            </h1>
        </div>
    </div>
);

export default NavBar;