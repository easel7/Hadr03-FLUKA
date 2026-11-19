#ifndef FLUKAIonInelasticPhysics_h
#define FLUKAIonInelasticPhysics_h 1

#include "G4VPhysicsConstructor.hh"

class FLUKAIonInelasticPhysics final : public G4VPhysicsConstructor
{
  public:
    FLUKAIonInelasticPhysics();
    void ConstructParticle() override;
    void ConstructProcess() override;
};

#endif
