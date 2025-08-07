const express = require('express');
const app = express();

app.get('/admin', (req, res) => {
  res.send('Welcome to the Admin Panel!')
});

const users = [
  {email: 'logan@test.com', password: '1234', role: 'user', id: '1'},
  {email: 'megan@test.com', password: 'l@nG3r!P4sswxxxrD$1', role: 'admin', id: '2' },
];

app.post('/login', (req, res) => {
  const user = users.find((u) => u.email === req.body.email);
  if (user.role === 'admin') {
    console.log(user.email + ' logged in as Admin with password:' + user.password)
  }
});

app.listen(3000, () => {
  console.log(`Server is running on port 3000`);
});
