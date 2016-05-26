#include <mammut/mammut.hpp>


using namespace mammut;


extern "C" {

  /** mammut.hpp *****************************/
  /** Class Mammut */
  Mammut *create_Mammut() {return new Mammut();}
  void destroy_Mammut(Mammut *m){delete m;}
  cpufreq::CpuFreq* getInstanceCpuFreq(){ return getInstanceCpuFreq();}
  energy::Energy* getInstanceEnergy(Mammut* m){ return m->getInstanceEnergy();}
  task::TasksManager* getInstanceTask(Mammut* m){ return m->getInstanceTask();}
  topology::Topology* getInstanceTopology(Mammut* m){ return m->getInstanceTopology();}
  /** mammut.hpp *****************************/

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


  /** energy.hpp *****************************/
  /** Class Energy */
  energy::Counter* getCounter(energy::Energy* e){return e->getCounter();}

  /** Class Counter */
  energy::Joules getJoules(energy::Counter* c){
    return  c->getJoules();
  }
  void reset(energy::Counter* c){return c->reset();}
  bool init(energy::Counter* c){return c->init();}
  energy::CounterType getType(energy::Counter*c){return c ->getType();}

  /** Class CounterCpus */
  /* TODO getCpus */

  energy::Joules getJoulesCpu(energy::Counter* c, topology::CpuId cpuId){
    return ((energy::CounterCpus*)c)->getJoulesCpu(cpuId);
  }
  energy::Joules getJoulesCpuAll(energy::Counter* c){
    return  ((energy::CounterCpus*)c)->getJoulesCpuAll();
  }
  energy::Joules getJoulesCores(energy::Counter* c, topology::CpuId cpuId){
    return ((energy::CounterCpus*)c)->getJoulesCores(cpuId);
  }
  energy::Joules getJoulesCoresAll(energy::Counter* c){
    return  ((energy::CounterCpus*)c)->getJoulesCoresAll();
  }
  int hasJoulesGraphic(energy::Counter* c){
      return ((energy::CounterCpus*)c)->hasJoulesGraphic();
  }
  energy::Joules getJoulesGraphic(energy::Counter* c, topology::CpuId cpuId){
    return  ((energy::CounterCpus*)c)->getJoulesGraphic(cpuId);
  }
  energy::Joules getJoulesGraphicAll(energy::Counter* c){
    return  ((energy::CounterCpus*)c)->getJoulesGraphicAll();
  }
  int hasJoulesDram(energy::Counter* c){
      return ((energy::CounterCpus*)c)->hasJoulesDram();
  }
  energy::Joules getJoulesDram(energy::Counter* c, topology::CpuId cpuId){
    return  ((energy::CounterCpus*)c)->getJoulesDram(cpuId);
  }
  energy::Joules getJoulesDramAll(energy::Counter* c){
    return  ((energy::CounterCpus*)c)->getJoulesDramAll();
  }

  /***************************** energy.hpp **/

}
