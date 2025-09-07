import React, { useState } from "react";
import "../App.css";

function App() {
  const [darkMode, setDarkMode] = useState(false);

  return (
    <div className={darkMode ? "app dark" : "app"}>
      <header className="header">
        <h1>Ethereum DEX (Improved)</h1>
        <button onClick={() => setDarkMode(!darkMode)} className="toggle-btn">
          {darkMode ? "☀️ Light Mode" : "🌙 Dark Mode"}
        </button>
      </header>

      <main className="content">
        <p>
          Welcome to the improved Ethereum DEX!  
          Now deployed on <strong>Goerli</strong> testnet.
        </p>
        <ul>
          <li>✅ Deposit & withdraw ERC20 tokens</li>
          <li>✅ Dark/Light theme toggle</li>
          <li>✅ Goerli network support</li>
        </ul>
      </main>

      <footer className="footer">
        <p>Built using Solidity + React</p>
      </footer>
    </div>
  );
}

export default App;

