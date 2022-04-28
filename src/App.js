import React from 'react';
import logo from './smd.svg';
import ttech from './ttech.svg';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />

        <Numbers></Numbers>

      </header>
      <footer>

        <img src={ttech} className="footer-logo" alt="logo" />
      </footer>
    </div>
  );
}


function Numbers() {
  const [checked, setChecked] = React.useState(false);
  const handleChange = () => {
    setChecked(!checked);
  };

  function verify () {
    let options = {};
    if (checked) {
      options = {
        headers: {
          "X-Forwarded-For": "81.45.2.129:3863"
        }
      }
    }
    fetch('https://smartdigits-hugo.eng.smartdigits.io/anti-spoofer/verify', options)
    .then(response => response.json())
    .then(data => console.log(data));
  }

  return (
    <div className="Support">
      <p>Quick verified support</p>
      <a href="tel:+441344959585" onClick={verify}>+441344959585</a>
      <p>Slow unverified support</p>
      <a href="tel:+441344959585">+441344959585</a>
      <div>
      <input 
      type="checkbox"
      checked={checked}
      onChange={handleChange}
      />

      Mocked IP address
      </div>

    </div>
  )
}


export default App;
