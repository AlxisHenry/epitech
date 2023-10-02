import "@/styles/components/Card.scss"

type ProjectProps = {
	key: number,
	project: {
		title: string,
		image: string,
		link: string,
		description: string,
	}
}

export default function Project(props: ProjectProps) {
	return (
		<div className="card">
			<div className="card-image">
				<figure className="image is-4by3">
					<img src={props.project.image} alt={props.project.title} />
				</figure>
			</div>
			<div className="card-content">
				<div className="media">
					<div className="media-content">
						<p className="title is-4">{props.project.title}</p>
					</div>
				</div>
				<div className="content">
					{props.project.description}<br/>
					<a target="_blank" href={props.project.link}>View</a>
				</div>
			</div>
		</div>
	)
}