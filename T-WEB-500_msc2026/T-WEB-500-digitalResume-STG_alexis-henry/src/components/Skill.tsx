import "@/styles/components/Card.scss"

type SkillProps = {
	key: number,
	skill: {
		title: string,
		image: string,
		description: string,
	}
}

export default function Skill(props: SkillProps) {
  return (
    <div className="card" key={props.key}>
      <div className="card-image">
        <figure className="image is-4by3">
          <img src={props.skill.image} alt={props.skill.title} />
        </figure>
      </div>
      <div className="card-content">
        <div className="media">
          <div className="media-content">
            <p className="title is-4">{props.skill.title}</p>
          </div>
        </div>
        <div className="content">
          {props.skill.description}
        </div>
      </div>
    </div>
  );
}
