function TryReact() {
    const element = React.createElement(
	'h1',
	{className: 'greeting'},
	'Bonjour, monde !'
    );
    ReactDOM.render(element, document.getElementById('ResultsFromServices'));
};

class ShoppingList extends React.Component {
  render() {
    return (
      <div className="shopping-list">
        <h1>Liste de courses pour {this.props.name}</h1>
        <ul>
          <li>Instagram</li>
          <li>WhatsApp</li>
          <li>Oculus</li>
        </ul>
      </div>
    );
  }
}
