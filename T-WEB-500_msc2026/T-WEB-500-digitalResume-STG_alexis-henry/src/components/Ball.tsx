import { useEffect, useState } from "react";
import { loader } from "@/services/constants";
import "@/styles/components/Ball.scss";

export default function Ball(props: { step: number; direction: string }) {
  
  useEffect(() => {
    if (props.step === loader.hitStep && props.direction === "down") {
      new Audio("/loader/sounds/hit.mp3").play();
    } else if (props.step === loader.maxStep) {
      new Audio("/loader/sounds/hole.mp3").play();
    }
  }, [props.step]);

  return <div className={`ball ${props.step >= loader.hitStep ? "hit" : ""}`}></div>;
}
