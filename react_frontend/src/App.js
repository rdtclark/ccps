import React from 'react';
import './App.css';
import PartnersContainer from './containers/PartnersContainer';
import JobsContainer from './containers/JobsContainer';

function App() {
  return (
    <div>
      <div className="partners">
      <PartnersContainer/>
      </div>
      <div className="jerbs">
      <JobsContainer/>
      </div>
    </div>
  );
}

export default App;
