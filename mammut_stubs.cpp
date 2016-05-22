#include <mammut/mammut.hpp>


using namespace mammut;


extern "C" {

  /** Class Mammut */
  Mammut *create_Mammut() {return new Mammut();}
  void destroy_Mammut(Mammut *m){delete m;}
  cpufreq::CpuFreq* getInstanceCpuFreq(){ return getInstanceCpuFreq();}
  energy::Energy* getInstanceEnergy(Mammut* m){ return m->getInstanceEnergy();}
  task::TasksManager* getInstanceTask(Mammut* m){ return m->getInstanceTask();}
  topology::Topology* getInstanceTopology(Mammut* m){ return m->getInstanceTopology();}

  /** Class CpuFreq */
  using namespace cpufreq;
  std::vector<Domain*> getDomains(CpuFreq* c) {return c->getDomains();}
  Domain *getDomain(CpuFreq* c, topology::VirtualCore* v)
  {return c->getDomain(v);}
  std::vector<Domain*> getDomainsV(CpuFreq* c, std::vector<topology::VirtualCore*>& v) {return c->getDomains(v);}
  std::vector<Domain*> getDomainsComplete(CpuFreq* c, std::vector<topology::VirtualCore*>& v) {return c->getDomainsComplete(v);}
  std::vector<RollbackPoint> getRollbackPoint(CpuFreq* c){return c->getRollbackPoints();}
  void rollback(CpuFreq* c, std::vector<RollbackPoint>& r ){return c->rollback(r);}
  bool isGovernorAvailable(CpuFreq* c, Governor g){return c->isGovernorAvailable(g);}
  bool isBoostingSupported(CpuFreq* c){return c->isBoostingSupported();}
  bool isBoostingEnabled(CpuFreq* c){return c->isBoostingEnabled();}
  void enableBoosting(CpuFreq* c){return c->enableBoosting();}
  void disableBoosting(CpuFreq* c){return c->disableBoosting();}
  Governor getGovernorFromGovernorName(CpuFreq* c, const std::string& gn){return c->getGovernorFromGovernorName(gn);}
  
  
  
  /** Class Energy */
  energy::Counter* getCounter(energy::Energy* e){return e->getCounter();}
  /** Class Counter */
  energy::Joules getJoules(energy::Counter* c){
    return  c->getJoules();
  }
  void reset(energy::Counter* c){return c->reset();}
  bool init(energy::Counter* c){return c->init();}
  
}
