import React from "react";
import { Link } from "react-router-dom";

const NavBar = () => (
    <ul>
        <li>
            <Link to="/">Home</Link>
        </li>
        <li>
            <Link to="/organisations">Organisations</Link>
        </li>
        <li>
            <Link to="/jobs">Jobs</Link>
        </li>
    </ul>
);

export default NavBar;