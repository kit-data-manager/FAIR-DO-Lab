POST http://localhost:8090/api/v1/search?page=0&size=20
accept: application/hal+json
Content-Type: application/json
{
  "query": {
    "exists" : {
      "field" : "pid"
    }
  },
  "_source": ["pid"]
}