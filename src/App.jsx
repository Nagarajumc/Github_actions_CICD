import React from "react";
import logo from "./logo.svg";
import "./App.css";

export default function App() {
  return (
    <div className="App"> 
      <header className="App-header"> 
        <img src={logo} className="App-logo" alt="logo" />
        <h1>React + Docker + EC2</h1>
        <p>Deployed via GitHub Actions — Simple flow 🚀</p>
      </header>
    </div>
  );
}