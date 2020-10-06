from franz.openrdf.sail.allegrographserver import AllegroGraphServer
from franz.openrdf.repository.repository import Repository
server=AllegroGraphServer(host="CallistoAllegro",port="{{allegro_port}}",user="{{allegro_user}}",password="{{allegro_password}}")
catalog = server.openCatalog('')
mode = Repository.ACCESS
repository = catalog.getRepository("demonstration",mode)
repository.initialize()
conn = repository.getConnection()
conn.addFile("./demonstration.nt",format="application/n-triples")
