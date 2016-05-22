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

  /** Class Energy */
  energy::Counter* getCounter(energy::Energy* e){return e->getCounter();}


  /** Class Counter */
  energy::Joules getJoules(energy::Counter* c){
    return  c->getJoules();
  }
  void reset(energy::Counter* c){return c->reset();}
  bool init(energy::Counter* c){return c->init();}
  
}
